(() => {
  'use strict';

  const input = document.getElementById('search');
  const cards = Array.from(document.querySelectorAll('.card'));
  const counter = document.getElementById('counter');
  const empty = document.getElementById('empty');
  const clearButton = document.getElementById('clear-search');

  if (!input || !counter || !empty || !clearButton) return;

  const normalize = value => value
    .toLocaleLowerCase('tr-TR')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/ı/g, 'i')
    .replace(/İ/g, 'i')
    .trim();

  const update = () => {
    const query = normalize(input.value);
    let visibleCount = 0;

    cards.forEach(card => {
      const searchableText = normalize([
        card.textContent,
        card.dataset.search || '',
        card.dataset.category || ''
      ].join(' '));
      const matches = !query || searchableText.includes(query);

      card.hidden = !matches;
      if (matches) visibleCount += 1;
    });

    counter.textContent = `${visibleCount} kaynak`;
    empty.hidden = visibleCount !== 0;
    clearButton.hidden = input.value.length === 0;
  };

  input.addEventListener('input', update);

  clearButton.addEventListener('click', () => {
    input.value = '';
    update();
    input.focus();
  });

  document.addEventListener('keydown', event => {
    const target = event.target;
    const isTyping = target instanceof HTMLElement &&
      (target.isContentEditable || ['INPUT', 'TEXTAREA', 'SELECT'].includes(target.tagName));

    if (event.key === '/' && !isTyping && !event.ctrlKey && !event.metaKey && !event.altKey) {
      event.preventDefault();
      input.focus();
    }

    if (event.key === 'Escape' && document.activeElement === input) {
      input.value = '';
      update();
      input.blur();
    }
  });

  update();
})();
