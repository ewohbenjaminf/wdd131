
/* Discover Nigeria - WDD 131 Project */

const destinations = [
    { name: "Obudu Mountain Resort", state: "Cross River" },
    { name: "Yankari Game Reserve", state: "Bauchi" },
    { name: "Olumo Rock", state: "Ogun" },
    { name: "Zuma Rock", state: "Niger" },
    { name: "Idanre Hills", state: "Ondo" },
    { name: "Lekki Conservation Centre", state: "Lagos" }
];

function updateFooter() {
    const yearElement = document.querySelector("#currentyear");
    const modifiedElement = document.querySelector("#lastModified");

    if (yearElement) {
        yearElement.textContent = `${new Date().getFullYear()}`;
    }

    if (modifiedElement) {
        modifiedElement.textContent =
            `Last Modification: ${document.lastModified}`;
    }
}

function populateDestinations() {
    const select = document.querySelector("#favorite-destination");

    if (!select) {
        return;
    }

    destinations.forEach((destination) => {
        const option = document.createElement("option");
        option.value = destination.name;
        option.textContent = `${destination.name} — ${destination.state}`;
        select.appendChild(option);
    });
}

function displaySavedPreference() {
    const message = document.querySelector("#saved-preference");
    const savedDestination =
        localStorage.getItem("discoverNigeriaFavorite");

    if (message && savedDestination) {
        message.textContent =
            `Your saved Nigerian destination is ${savedDestination}.`;
    }
}

function handleFeedbackForm() {
    const form = document.querySelector("#feedback-form");
    const message = document.querySelector("#feedback-message");
    const countElement = document.querySelector("#feedback-count");

    if (!form) {
        return;
    }

    const savedCount =
        Number(localStorage.getItem("discoverNigeriaFeedbackCount")) || 0;

    if (countElement) {
        countElement.textContent = `${savedCount}`;
    }

    form.addEventListener("submit", (event) => {
        event.preventDefault();

        const name = document.querySelector("#visitor-name").value.trim();
        const destination =
            document.querySelector("#favorite-destination").value;
        const feedback =
            document.querySelector("#visitor-feedback").value.trim();

        if (!name || !destination || !feedback) {
            if (message) {
                message.textContent =
                    "Please complete all required fields.";
            }
            return;
        }

        const newCount =
            (Number(localStorage.getItem("discoverNigeriaFeedbackCount")) || 0) + 1;

        localStorage.setItem(
            "discoverNigeriaFeedbackCount",
            `${newCount}`
        );

        localStorage.setItem(
            "discoverNigeriaFavorite",
            destination
        );

        if (message) {
            message.textContent =
                `Thank you, ${name}! Your feedback has been recorded in this browser.`;
        }

        if (countElement) {
            countElement.textContent = `${newCount}`;
        }

        form.reset();
        displaySavedPreference();
    });
}

updateFooter();
populateDestinations();
displaySavedPreference();
handleFeedbackForm();
