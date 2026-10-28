/** Texturas procedurales (canvas) para la Luna y Marte: sin descargas ni assets externos. */

function mulberry32(seed: number) {
  return () => {
    seed |= 0;
    seed = (seed + 0x6d2b79f5) | 0;
    let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

/** Ruido de valor fractal, periódico en x para que la textura cierre sin costura. */
function makeNoise(rand: () => number, size = 64) {
  const grid = Float32Array.from({ length: size * size }, rand);
  const at = (x: number, y: number) => grid[(((y % size) + size) % size) * size + (((x % size) + size) % size)];
  const smooth = (t: number) => t * t * (3 - 2 * t);
  const value = (x: number, y: number) => {
    const x0 = Math.floor(x);
    const y0 = Math.floor(y);
    const fx = smooth(x - x0);
    const fy = smooth(y - y0);
    const top = at(x0, y0) * (1 - fx) + at(x0 + 1, y0) * fx;
    const bottom = at(x0, y0 + 1) * (1 - fx) + at(x0 + 1, y0 + 1) * fx;
    return top * (1 - fy) + bottom * fy;
  };
  return (x: number, y: number, octaves = 5) => {
    let sum = 0;
    let amp = 0.5;
    let freq = 1;
    for (let i = 0; i < octaves; i++) {
      sum += amp * value(x * freq, y * freq);
      amp /= 2;
      freq *= 2;
    }
    return sum;
  };
}

type RGB = [number, number, number];
const mix = (a: RGB, b: RGB, t: number): RGB => [
  a[0] + (b[0] - a[0]) * t,
  a[1] + (b[1] - a[1]) * t,
  a[2] + (b[2] - a[2]) * t,
];

function paint(
  w: number,
  h: number,
  seed: number,
  shade: (n: number, v: number, detail: number) => RGB,
): HTMLCanvasElement {
  const canvas = document.createElement("canvas");
  canvas.width = w;
  canvas.height = h;
  const ctx = canvas.getContext("2d")!;
  const img = ctx.createImageData(w, h);
  const noise = makeNoise(mulberry32(seed));
  for (let y = 0; y < h; y++) {
    for (let x = 0; x < w; x++) {
      const base = noise((x / w) * 8, (y / h) * 4, 6);
      const detail = noise((x / w) * 48, (y / h) * 24, 3);
      const [r, g, b] = shade(base, y / h, detail);
      const i = (y * w + x) * 4;
      img.data[i] = r;
      img.data[i + 1] = g;
      img.data[i + 2] = b;
      img.data[i + 3] = 255;
    }
  }
  ctx.putImageData(img, 0, 0);
  return canvas;
}

function addCraters(canvas: HTMLCanvasElement, seed: number, count: number, maxR: number) {
  const ctx = canvas.getContext("2d")!;
  const rand = mulberry32(seed);
  for (let i = 0; i < count; i++) {
    const x = rand() * canvas.width;
    const y = rand() * canvas.height;
    const r = 2 + Math.pow(rand(), 3) * maxR;
    const g = ctx.createRadialGradient(x, y, r * 0.2, x, y, r);
    g.addColorStop(0, "rgba(0,0,0,0.28)");
    g.addColorStop(0.8, "rgba(0,0,0,0.12)");
    g.addColorStop(0.92, "rgba(255,255,255,0.22)");
    g.addColorStop(1, "rgba(255,255,255,0)");
    ctx.fillStyle = g;
    ctx.beginPath();
    ctx.arc(x, y, r, 0, Math.PI * 2);
    ctx.fill();
  }
}

export function createMoonTexture(): HTMLCanvasElement {
  const dark: RGB = [70, 70, 74];
  const light: RGB = [190, 188, 182];
  const canvas = paint(1024, 512, 7, (n, _v, d) => {
    // "Mares" lunares: zonas basálticas más oscuras.
    const t = Math.min(1, Math.max(0, (n - 0.3) * 2.2));
    const c = mix(dark, light, t);
    const k = 0.85 + d * 0.3;
    return [c[0] * k, c[1] * k, c[2] * k];
  });
  addCraters(canvas, 11, 260, 26);
  return canvas;
}

export function createMarsTexture(): HTMLCanvasElement {
  const dust: RGB = [196, 106, 58];
  const rust: RGB = [140, 62, 34];
  const dark: RGB = [74, 40, 30];
  const ice: RGB = [240, 238, 235];
  const canvas = paint(1024, 512, 21, (n, v, d) => {
    let c = mix(rust, dust, Math.min(1, Math.max(0, (n - 0.25) * 2.4)));
    // Regiones oscuras tipo Syrtis Major.
    c = mix(c, dark, Math.max(0, 0.42 - n) * 2.2);
    const k = 0.9 + d * 0.2;
    c = [c[0] * k, c[1] * k, c[2] * k];
    // Casquetes polares.
    const pole = Math.min(v, 1 - v);
    if (pole < 0.06) c = mix(c, ice, Math.min(1, (0.06 - pole) / 0.03));
    return c;
  });
  addCraters(canvas, 5, 120, 18);
  return canvas;
}
