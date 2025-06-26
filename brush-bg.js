// brush-bg.js
window.onload = function () {
  const canvas = document.createElement('canvas');
  canvas.id = 'brush-canvas';
  document.body.appendChild(canvas);

  const ctx = canvas.getContext('2d');

  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }

  window.addEventListener('resize', resizeCanvas);
  resizeCanvas();

  // Set background color
  document.body.style.backgroundColor = '#e1c67e';

  const brushColor = '#75adab';
  const numStrokes = 22; // slight increase in strokes

  function drawTaperedBrushStroke(x, y, length, thickness, angle) {
    ctx.save();
    ctx.translate(x, y);
    ctx.rotate(angle);

    ctx.beginPath();

    // More pronounced curve
    const curveHeight = (Math.random() - 0.5) * thickness * 4;

    // Top edge of the stroke
    ctx.moveTo(0, 0);
    ctx.quadraticCurveTo(length / 2, curveHeight, length, 0);

    // Bottom edge (closing stroke with taper)
    ctx.lineTo(length, thickness * 0.1);
    ctx.quadraticCurveTo(length / 2, curveHeight + thickness, 0, thickness * 0.1);
    ctx.closePath();

    ctx.fillStyle = brushColor;
    ctx.globalAlpha = 0.35 + Math.random() * 0.3;
    ctx.fill();

    ctx.restore();
  }

  function drawBrushStrokes() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    for (let i = 0; i < numStrokes; i++) {
      const x = Math.random() * canvas.width;
      const y = Math.random() * canvas.height;
      const length = 100 + Math.random() * 130;
      const thickness = 18 + Math.random() * 10;
      const angle = Math.random() * Math.PI * 2;

      drawTaperedBrushStroke(x, y, length, thickness, angle);
    }
  }

  drawBrushStrokes();

  // Optional: click to regenerate new strokes
  canvas.addEventListener('click', drawBrushStrokes);
};
