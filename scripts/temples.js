// ==============================
// HAMBURGER MENU
// ==============================

const menuButton = document.querySelector("#menu-button");
const navigation = document.querySelector("#navigation");

if (menuButton && navigation) {
    menuButton.addEventListener("click", () => {
        navigation.classList.toggle("open");

        const isOpen = navigation.classList.contains("open");

        if (isOpen) {
            menuButton.textContent = "✕";
            menuButton.setAttribute("aria-label", "Close navigation menu");
            menuButton.setAttribute("aria-expanded", "true");
        } else {
            menuButton.textContent = "☰";
            menuButton.setAttribute("aria-label", "Open navigation menu");
            menuButton.setAttribute("aria-expanded", "false");
        }
    });
}


// ==============================
// CURRENT YEAR
// ==============================

const currentYear = new Date().getFullYear();
const yearElement = document.querySelector("#currentyear");

if (yearElement) {
    yearElement.textContent = currentYear;
}


// ==============================
// LAST MODIFIED DATE
// ==============================

const lastModified = document.lastModified;
const modifiedElement = document.querySelector("#lastModified");

if (modifiedElement) {
    modifiedElement.textContent = `Last Modified: ${lastModified}`;
}