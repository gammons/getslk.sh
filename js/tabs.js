// js/tabs.js
function wireTabsGroup(group) {
  const tabs = group.querySelectorAll('[data-tab]');
  const panels = group.querySelectorAll('[data-panel]');
  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      const target = tab.dataset.tab;
      tabs.forEach(t => t.setAttribute('aria-selected', String(t === tab)));
      panels.forEach(p => {
        if (p.dataset.panel === target) p.removeAttribute('hidden');
        else p.setAttribute('hidden', '');
      });
    });
  });
}

export function initTabs(root = document) {
  if (root instanceof Element && root.matches('[data-tabs]')) {
    wireTabsGroup(root);
  }
  root.querySelectorAll('[data-tabs]').forEach(wireTabsGroup);
}

if (typeof document !== 'undefined' && document.readyState !== 'loading') {
  initTabs();
} else if (typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', () => initTabs());
}
