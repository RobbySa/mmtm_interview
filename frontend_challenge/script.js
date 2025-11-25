// ------------------------
// Button success logic
// ------------------------
const form = document.getElementById("subscribeForm");
const btn = document.getElementById("subscribeBtn");
const commonBtnClasses = "p-3 gap-2 flex items-center justify-center rounded-xl shadow-md text-white";

form.addEventListener("submit", (e) => {
  e.preventDefault();

  btn.className = commonBtnClasses + " bg-green-600 transition-all";
  btn.innerHTML = `<i class="fa-solid fa-circle-check"></i> Success!`;

  form.reset();

  // Ensure button changes only lasts 4 seconds
  setTimeout(() => {
    btn.className = commonBtnClasses + " bg-blue-600 hover:bg-blue-700 transition-transform active:scale-95";
    btn.innerHTML = `<i class="fa-solid fa-paper-plane"></i> Subscribe`;
  }, 4000);
});

// ------------------------
// Smooth animated gradient
// ------------------------

// Gradient color stops
const colors = [
  [165, 180, 252], // #a5b4fc
  [240, 171, 252], // #f0abfc
  [110, 231, 183], // #6ee7b7
  [59, 130, 246],  // #3b82f6
  [252, 211, 77],  // #fcd34d
  [248, 113, 113]  // #f87171
];

let step = 0;
let gradientSpeed = 0.002; // smaller = slower
let colorIndices = [0, 1, 2, 3]; // start and end colors

function updateGradient() {
  const c0_0 = colors[colorIndices[0]];
  const c0_1 = colors[colorIndices[1]];
  const c1_0 = colors[colorIndices[2]];
  const c1_1 = colors[colorIndices[3]];

  // Interpolate colors
  const r1 = Math.round((1 - step) * c0_0[0] + step * c0_1[0]);
  const g1 = Math.round((1 - step) * c0_0[1] + step * c0_1[1]);
  const b1 = Math.round((1 - step) * c0_0[2] + step * c0_1[2]);

  const r2 = Math.round((1 - step) * c1_0[0] + step * c1_1[0]);
  const g2 = Math.round((1 - step) * c1_0[1] + step * c1_1[1]);
  const b2 = Math.round((1 - step) * c1_0[2] + step * c1_1[2]);

  document.body.style.background = `linear-gradient(135deg, rgb(${r1},${g1},${b1}), rgb(${r2},${g2},${b2}))`;

  step += gradientSpeed;
  if (step >= 1) {
    step %= 1;
    colorIndices[0] = colorIndices[1];
    colorIndices[2] = colorIndices[3];

    // pick new target indices
    colorIndices[1] = (colorIndices[1] + Math.floor(1 + Math.random() * (colors.length - 1))) % colors.length;
    colorIndices[3] = (colorIndices[3] + Math.floor(1 + Math.random() * (colors.length - 1))) % colors.length;
  }

  requestAnimationFrame(updateGradient);
}

// Start the gradient animation
updateGradient();
