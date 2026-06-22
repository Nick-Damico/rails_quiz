/* PUBLIC HELPERS */
function removeDisabledAttribute(element) {
  if (_elementHasAttribute(element, "disabled")) {
    _removeAttribute(element, "disabled");
  }
}

function addDisabledAttribute(element) {
  if (!_elementHasAttribute(element, "disabled")) {
    _addAttribute(element, "disabled");
  }
}


function isDisabled(element) {
  return _elementHasAttribute(element, "disabled");
}

function toggleHidden(element) {
  element.classList.toggle("hidden");
}

function addClass(element, className) {
  if (_elementHasClass(element, className)) return;

  _addClass(element, className);
}

function removeHiddenClass(element) {
  if (_elementHasClass(element, "hidden")) {
    _removeClass(element, "hidden");
  }
}

function removeClass(element, className) {
  if (_elementHasClass(element, className)) {
    _removeClass(element, className);
  }
}

function isHidden(element) {
  return _elementHasClass(element, "hidden");
}

/* PRIVATE HELPERS */
function _elementHasAttribute(element, attribute) {
  return element.hasAttribute(attribute);
}

function _removeAttribute(element, attribute) {
  element.removeAttribute(attribute);
}

function _elementHasClass(element, className) {
  return element.classList.contains(className);
}

function _addClass(element, className) {
  element.classList.add(className);
}

/* TODO: MDN - Look into using TrustedHTML element instead of setAttribute */
function _addAttribute(element, attribute) {
  element.setAttribute(attribute, attribute);
}

function _removeClass(element, className) {
  element.classList.remove(className);
}

/* EXPORT METHODS */
export {
  addClass,
  addDisabledAttribute,
  isDisabled,
  isHidden,
  removeClass,
  removeDisabledAttribute,
  removeHiddenClass,
  toggleHidden
};
