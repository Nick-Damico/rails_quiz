function capitalize(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

function normalize(string) {
  return string.toLowerCase().trim();
}

export { capitalize, normalize };
