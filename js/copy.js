// js/copy.js
export function initCopyButtons(root = document) {
  root.querySelectorAll('[data-copy]').forEach(btn => {
    btn.addEventListener('click', async () => {
      const block = btn.parentElement;
      // Take the parent's text content minus the button's text.
      const text = Array.from(block.childNodes)
        .filter(n => n !== btn)
        .map(n => n.textContent)
        .join('')
        .trim();
      try {
        await navigator.clipboard.writeText(text);
      } catch { return; }
      const original = btn.textContent;
      btn.textContent = 'copied!';
      btn.classList.add('is-copied');
      setTimeout(() => {
        btn.textContent = original;
        btn.classList.remove('is-copied');
      }, 1200);
    });
  });
}

if (typeof document !== 'undefined' && document.readyState !== 'loading') {
  initCopyButtons();
} else if (typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', () => initCopyButtons());
}
