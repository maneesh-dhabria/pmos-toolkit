# File Upload

## When to use
- User uploads files (documents, images, attachments)
- Single or multiple files

## When NOT to use
- Pasting/typing content → text input or textarea
- Capturing photo on mobile → use camera capture pattern with `accept="image/*" capture="environment"`

## Anatomy
1. Drop zone with prompt ("Drop files or click to browse")
2. File picker trigger (hidden `<input type="file">`)
3. File list / thumbnails of selected files
4. Per-file: name, size, remove button, progress bar (during upload)
5. Constraints displayed: accepted types, max size, max count
6. Error slot

## Required states
- default (empty drop zone)
- drag-over (highlighted)
- with-files (list of selected)
- uploading (progress bar per file)
- upload-complete
- upload-failed (with retry)
- rejected-file (wrong type/too big)

## Best practices
1. Always show constraints upfront: "PNG or JPG, up to 10 MB each" (N5, N1)
2. Drop zone responds to dragover with clear visual change (N1)
3. Allow both drop AND click — click is fallback for non-mouse users (N7, A3)
4. Per-file progress bar, not just an overall spinner (N1)
5. Selected files removable BEFORE upload (N3)
6. After upload: thumbnail preview for images, filename + icon for others (N6)
7. Reject invalid files with specific error: "PDF.exe is not allowed (only PNG, JPG)" (N9)
8. Mobile: use native picker; expose camera/gallery options (D1)
9. Drop zone has aria-label and the input is properly labeled (A4)

## Common mistakes
- No constraints shown until rejection → user wastes time uploading the wrong file (N5)
- Single overall spinner during multi-file upload → can't tell which file is stuck (N1)
- No per-file remove → user has to start over (N3)
- Drop zone too small → hard to drop accurately (F1)
- No fallback click trigger → broken without drag (A3)

## Device variants
- **mobile-web/native**: prefer system file picker; offer camera capture for image uploads
- **desktop**: drag-and-drop primary, click as fallback

## Skeleton

```html
<div class="wf-stack" style="max-width:540px">
  <label class="mock-label">Attachments</label>
  <div class="placeholder" style="min-height:160px;flex-direction:column;border-style:dashed;border-color:var(--wf-border)" role="button" tabindex="0" aria-label="Drop files or click to browse">
    <span style="font-size:24px">📎</span>
    <strong>Drop files here, or click to browse</strong>
    <span class="wf-muted">PNG, JPG, PDF · up to 10 MB each</span>
  </div>

  <!-- File list -->
  <div class="wf-stack">
    <div class="mock-card wf-row">
      <span>📄</span>
      <div class="wf-grow">
        <div>release-notes.pdf</div>
        <div class="wf-muted" style="font-size:12px">2.3 MB · uploaded</div>
      </div>
      <button class="mock-button" aria-label="Remove">×</button>
    </div>
    <div class="mock-card wf-row">
      <span>🖼️</span>
      <div class="wf-grow">
        <div>screenshot.png</div>
        <div class="skeleton" style="margin-top:4px;width:60%"></div>
      </div>
      <span class="wf-muted">62%</span>
    </div>
  </div>
</div>
```
