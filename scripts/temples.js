// ==============================
// HAMBURGER MENU
// ==============================

const menuButton = document.querySelector("#menu-button");
const navigation = document.querySelector("#navigation");

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


// ==============================
// CURRENT YEAR
// ==============================

const currentYear = new Date().getFullYear();

document.querySelector("#currentyear").textContent = currentYear;


// ==============================
// LAST MODIFIED DATE
// ==============================

const lastModified = document.lastModified;

document.querySelector("#lastModified").textContent =
    `Last Modified: ${lastModified}`;