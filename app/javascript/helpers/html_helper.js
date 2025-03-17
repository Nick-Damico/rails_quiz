/* PUBLIC HELPERS */
function removeDisabledAttribute(element) {
  if (_elementHasAttribute(element, "disabled")) {
    _removeAttribute(element, "disabled");
  }
}

function removeHiddenClass(element) {
  if (_elementHasClass(element, "hidden")) {
    _removeClass(element, "hidden");
  }
}

function addClass(element, className) {
  if (_elementHasClass(element, className)) return;

  _addClass(element, className);
}

function removeClass(element, className) {
  if (_elementHasClass(element, className)) {
    _removeClass(element, className);
  }
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

function _removeClass(element, className) {
  element.classList.remove(className);
}

/* EXPORT METHODS */
export { addClass, removeClass, removeDisabledAttribute, removeHiddenClass };
