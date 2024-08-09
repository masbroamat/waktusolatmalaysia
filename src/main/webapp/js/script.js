document.addEventListener('mousemove', (e) => {
    const { clientX: x, clientY: y } = e;
    const { innerWidth: width, innerHeight: height } = window;
    
    // Calculate the offset based on the mouse position
    const offsetX = (x / width - 0.5) * 20; // Adjust multiplier for more/less movement
    const offsetY = (y / height - 0.5) * 20; // Adjust multiplier for more/less movement
    
    // Apply the transform to the background, limiting the values
    const parallaxElement = document.querySelector('.parallax');
    parallaxElement.style.transform = `translate(calc(-5% + ${offsetX}px), calc(-5% + ${offsetY}px))`;
  });

function updateLocationAndPrayerTimes() {
  const citySelect = document.getElementById('city');
  const selectedCity = citySelect.value;

  fetch('SolatServlet', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ city: selectedCity })
  })
  .then(response => response.json())
  .then(data => {
    updateLocation(data.location);
    updatePrayerTimes(data.prayerTimes);
  })
  .catch(error => {
    console.error('Error:', error);
  });
}

function updateLocation(location) {
  const locationSpan = document.querySelector('.location span:last-child');
  locationSpan.textContent = location;
}

function updatePrayerTimes(prayerTimes) {
  const clockContainers = document.querySelectorAll('.clocksub .clocknumber');
  clockContainers[0].textContent = prayerTimes.Fajr;
  clockContainers[1].textContent = prayerTimes.Dhuhr;
  clockContainers[2].textContent = prayerTimes.Asr;
  clockContainers[3].textContent = prayerTimes.Maghrib;
  clockContainers[4].textContent = prayerTimes.Isha;
}

function updateClock() {
            const now = new Date();
            const hours = now.getHours().toString().padStart(2, '0');
            const minutes = now.getMinutes().toString().padStart(2, '0');
            const seconds = now.getSeconds().toString().padStart(2, '0');
            
            document.getElementById('currentHour').textContent = hours;
            document.getElementById('currentMinute').textContent = minutes;
			document.getElementById('currentSecond').textContent = seconds;
        }

setInterval(updateClock, 1000);
updateClock(); 
		
// Function to hide the overlay
function hideOverlay() {
    const overlay = document.getElementById('overlay');
    if (overlay) {
        overlay.classList.add('hidden');
    }
}

window.addEventListener('load', () => {
    setTimeout(hideOverlay, 1000);
});

function updateCurrentPrayer() {
    // Get current time
    const currentHour = parseInt(document.getElementById('currentHour').textContent);
    const currentMinute = parseInt(document.getElementById('currentMinute').textContent);

    // Get prayer times
    const prayerTimes = [
        { name: 'Fajr', time: document.querySelector('.clocksub .clockcontainer:nth-child(1) .clocknumber').textContent },
        { name: 'Dhuhr', time: document.querySelector('.clocksub .clockcontainer:nth-child(2) .clocknumber').textContent },
        { name: 'Asr', time: document.querySelector('.clocksub .clockcontainer:nth-child(3) .clocknumber').textContent },
        { name: 'Maghrib', time: document.querySelector('.clocksub .clockcontainer:nth-child(4) .clocknumber').textContent },
        { name: 'Isha', time: document.querySelector('.clocksub .clockcontainer:nth-child(5) .clocknumber').textContent }
    ];

    // Parse prayer times
    prayerTimes.forEach(prayer => {
        const [hour, minute] = prayer.time.split(':').map(Number);
        prayer.hour = hour;
        prayer.minute = minute;
    });

    // Sort prayer times
    prayerTimes.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));

    // Find current prayer
    let currentPrayer = 'Isha'; // Default to Isha if before Fajr
    for (let i = 0; i < prayerTimes.length; i++) {
        if (currentHour < prayerTimes[i].hour || 
            (currentHour === prayerTimes[i].hour && currentMinute < prayerTimes[i].minute)) {
            currentPrayer = i === 0 ? prayerTimes[prayerTimes.length - 1].name : prayerTimes[i - 1].name;
            break;
        }
    }

    // Update the waktusolatsekarang div
    const waktuSolatSekarang = document.querySelector('.waktusolatsekarang');
    waktuSolatSekarang.innerHTML = `
        <span class="material-symbols-outlined">
            bedtime
        </span>
        ${currentPrayer}
    `;
}

// Call the function immediately
updateCurrentPrayer();

// Update every minute
setInterval(updateCurrentPrayer, 1000);