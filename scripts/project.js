// Discover Nigeria - WDD 131 Project

const currentYear = new Date().getFullYear();

const currentYearElement = document.querySelector("#currentyear");
if (currentYearElement) {
    currentYearElement.textContent = currentYear;
}

const lastModifiedElement = document.querySelector("#lastModified");
if (lastModifiedElement) {
    lastModifiedElement.textContent = `Last Modification: ${document.lastModified}`;
}