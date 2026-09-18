// ==============================
// W03 COUNTRY PAGE JAVASCRIPT
// ==============================

// Weather values
const temperature = 28;
const windSpeed = 10;
const conditions = "Partly Cloudy";

// Display weather information
document.querySelector("#temperature").textContent =
    `${temperature} °C`;

document.querySelector("#conditions").textContent =
    conditions;

document.querySelector("#wind").textContent =
    `${windSpeed} km/h`;


// Calculate wind chill in Celsius
function calculateWindChill(temp, speed) {
    return (
        13.12 +
        0.6215 * temp -
        11.37 * Math.pow(speed, 0.16) +
        0.3965 * temp * Math.pow(speed, 0.16)
    );
}


// Display wind chill only when conditions are met
const windChillElement = document.querySelector("#windchill");

if (temperature <= 10 && windSpeed > 4.8) {
    windChillElement.textContent =
        `${calculateWindChill(temperature, windSpeed).toFixed(1)} °C`;
} else {
    windChillElement.textContent = "N/A";
}


// Current year
document.querySelector("#currentyear").textContent =
    new Date().getFullYear();


// Last modified date
document.querySelector("#lastModified").textContent =
    document.lastModified;