// Click events are not attached to individual links, because those click events would have to be attached as each link is inserted. Instead, click events are bound to document:
document.addEventListener('click', function() {
  if(event.target.matches('.add-fields')) {
    time = new Date().getTime();
    regexp = new RegExp(event.target.dataset.id, 'g');
    html = event.target.dataset.fields.replace(regexp, time);
    event.target.insertAdjacentHTML('beforebegin', html);
    event.preventDefault();
  }

  if(event.target.matches('.remove-fields')) {
    event.target.parentNode.parentNode.querySelector("input[type='hidden']").value = 1;
    event.target.parentNode.remove();
    event.preventDefault();
  }
}, false);
