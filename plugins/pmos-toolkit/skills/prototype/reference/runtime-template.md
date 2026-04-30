# runtime.js Template

`assets/runtime.js` is shared across all per-device HTML files. It exposes globals on `window.__proto` so device files can consume them without modules. Loaded as plain JS (no Babel) so it works in every modern browser without compile.

## Required exports (on `window.__proto`)

| Name | Type | Purpose |
|------|------|---------|
| `useRoute()` | hook | returns `{path, params, navigate(p)}` for the current hash route |
| `navigate(path)` | function | imperative navigation; updates `window.location.hash` |
| `mockApi` | object | `{get, post, put, delete}` — all return Promises that resolve after simulated latency |
| `store` | object | in-memory keyed by entity name; mutations via `store.update / create / remove` |
| `loadMockData()` | function | called once on init; tries `fetch('./assets/<entity>.json')` per entity, falls back to `<script type="application/json" id="mock-<entity>">` if fetch fails |
| `simulateLatency(min=200, max=800)` | function | returns a Promise; used by mockApi |
| `injectErrors` | array | parsed from `?inject-errors=path1,path2`; mockApi consults this to deterministically fail listed paths |

## Generation rules for the subagent

1. Output ONE file: `{feature_folder}/prototype/assets/runtime.js`. No imports, no exports — assignments to `window.__proto.*`.
2. The file must be self-contained — no external network calls (besides the JSON fetches the loader makes).
3. The router must support hash routes like `#/users`, `#/users/:id`, `#/orders/new`. Param parsing required.
4. `loadMockData` must read the entity list from `<meta name="mock-entities" content="users,products,orders">` in the device file's `<head>` so it knows which JSON files / inline blocks to load.
5. The store must emit a tiny pub/sub so React components can subscribe (`store.subscribe(entity, callback)`); a basic `useStore(entity)` hook lives here too.
6. mockApi must respect `injectErrors` AND a route table that maps method+path to handler functions (CRUD on the store by default).

## Skeleton (subagent fills in actual logic; lengths are guidance)

```javascript
(() => {
  const proto = window.__proto = {};

  // ───────── 1. Latency ─────────
  proto.simulateLatency = (min = 200, max = 800) =>
    new Promise(r => setTimeout(r, min + Math.random() * (max - min)));

  // ───────── 2. Error injection ─────────
  const params = new URLSearchParams(window.location.search);
  proto.injectErrors = (params.get('inject-errors') || '').split(',').filter(Boolean);

  // ───────── 3. Store ─────────
  const data = {};
  const subs = new Map(); // entity → Set<callback>
  proto.store = {
    seed(entity, records) { data[entity] = records; emit(entity); },
    list(entity) { return data[entity] || []; },
    get(entity, id) { return (data[entity] || []).find(r => r.id === id); },
    create(entity, record) {
      data[entity] = data[entity] || [];
      const id = record.id || crypto.randomUUID();
      const full = { ...record, id, createdAt: new Date().toISOString() };
      data[entity].push(full);
      emit(entity);
      return full;
    },
    update(entity, id, patch) {
      const i = (data[entity] || []).findIndex(r => r.id === id);
      if (i < 0) return null;
      data[entity][i] = { ...data[entity][i], ...patch };
      emit(entity);
      return data[entity][i];
    },
    remove(entity, id) {
      data[entity] = (data[entity] || []).filter(r => r.id !== id);
      emit(entity);
    },
    subscribe(entity, cb) {
      if (!subs.has(entity)) subs.set(entity, new Set());
      subs.get(entity).add(cb);
      return () => subs.get(entity).delete(cb);
    }
  };
  function emit(entity) { (subs.get(entity) || []).forEach(cb => cb()); }

  // ───────── 4. Mock data loader (fetch + inline fallback) ─────────
  proto.loadMockData = async () => {
    const meta = document.querySelector('meta[name="mock-entities"]');
    const entities = (meta?.content || '').split(',').map(s => s.trim()).filter(Boolean);
    for (const entity of entities) {
      let records;
      try {
        const res = await fetch(`./assets/${entity}.json`);
        if (!res.ok) throw new Error('not ok');
        records = await res.json();
      } catch {
        // file:// fallback
        const inline = document.getElementById(`mock-${entity}`);
        records = inline ? JSON.parse(inline.textContent) : [];
      }
      proto.store.seed(entity, records);
    }
  };

  // ───────── 5. Mock API ─────────
  // Default convention: GET /<entity> → list; GET /<entity>/:id → get; POST /<entity> → create; PUT /<entity>/:id → update; DELETE /<entity>/:id → remove.
  // Subagent extends with feature-specific endpoints as needed.
  proto.mockApi = {
    async get(path)        { await proto.simulateLatency(); return handle('GET', path); },
    async post(path, body) { await proto.simulateLatency(); return handle('POST', path, body); },
    async put(path, body)  { await proto.simulateLatency(); return handle('PUT', path, body); },
    async delete(path)     { await proto.simulateLatency(); return handle('DELETE', path); }
  };
  function handle(method, path, body) {
    if (proto.injectErrors.includes(path)) throw new Error(`Injected failure: ${path}`);
    const m = path.match(/^\/([^\/]+)(?:\/([^\/]+))?$/);
    if (!m) throw new Error(`No handler for ${method} ${path}`);
    const [, entity, id] = m;
    if (method === 'GET' && !id)      return proto.store.list(entity);
    if (method === 'GET' && id)       return proto.store.get(entity, id);
    if (method === 'POST')            return proto.store.create(entity, body);
    if (method === 'PUT' && id)       return proto.store.update(entity, id, body);
    if (method === 'DELETE' && id)    return proto.store.remove(entity, id);
    throw new Error(`No handler for ${method} ${path}`);
  }

  // ───────── 6. Hash router ─────────
  function parseRoute() {
    const hash = window.location.hash.slice(1) || '/';
    return { path: hash, params: parseParams(hash) };
  }
  function parseParams(hash) {
    // very lightweight; extend per route table if needed
    return {};
  }
  proto.navigate = (path) => { window.location.hash = path; };
  proto.useRoute = () => {
    const [route, setRoute] = React.useState(parseRoute());
    React.useEffect(() => {
      const onChange = () => setRoute(parseRoute());
      window.addEventListener('hashchange', onChange);
      return () => window.removeEventListener('hashchange', onChange);
    }, []);
    return { ...route, navigate: proto.navigate };
  };

  // ───────── 7. useStore hook ─────────
  proto.useStore = (entity) => {
    const [, force] = React.useReducer(x => x + 1, 0);
    React.useEffect(() => proto.store.subscribe(entity, force), [entity]);
    return proto.store.list(entity);
  };

  // ───────── 8. Bootstrap ─────────
  proto.ready = proto.loadMockData();
})();
```

## Behavioral contract for the generator subagent

- Fill in route param parsing for the actual routes used by the prototype (e.g., `/users/:id`).
- Add custom mockApi handlers for any non-CRUD endpoints implied by the wireframes (e.g., `POST /auth/login` returns a fake session).
- Keep total file size under ~250 lines. If it grows beyond that, factor out custom handlers into a separate `assets/runtime-handlers.js` and load it after `runtime.js`.
- No external imports. No npm packages. No top-level `await` (load order matters in script tags).
