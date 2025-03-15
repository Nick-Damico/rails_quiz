/*
 * @param {HTMLElement} element
 * @return void
 */
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

function _elementHasAttribute(element, attribute) {
  return element.hasAttribute(attribute);
}

function _removeAttribute(element, attribute) {
  element.removeAttribute(attribute);
}

function _elementHasClass(element, className) {
  return element.classList.contains(className);
}

function _removeClass(element, className) {
  element.classList.remove(className);
}

export { removeDisabledAttribute, removeHiddenClass };
