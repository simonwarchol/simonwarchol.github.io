struct VertexOutput {
  @builtin(position) position : vec4 < f32>,
  @location(0) coord : vec2 < f32>,
};

struct Uniforms {
  time_since_start : f32,
};

@group(0)
@binding(0)
var<uniform> uniforms : Uniforms;

fn hash3(p : vec3 < f32>) -> f32 {
  return fract(sin(1e3 * dot(p, vec3 < f32 > (1.0, 57.0, -13.7))) * 4375.5453);
}

fn noise3(x : vec3 < f32>) -> f32 {
  let p : vec3 < f32> = floor(x);
  var f : vec3 < f32> = fract(x);
  f = f * f * (vec3 < f32 > (3.0, 3.0, 3.0) - vec3 < f32 > (2.0, 2.0, 2.0) * f);

  let mixed1 : f32 = mix(mix(hash3(p + vec3 < f32 > (0.0, 0.0, 0.0)), hash3(p + vec3 < f32 > (1.0, 0.0, 0.0)), f.x),
  mix(hash3(p + vec3 < f32 > (0.0, 1.0, 0.0)), hash3(p + vec3 < f32 > (1.0, 1.0, 0.0)), f.x), f.y);
  let mixed2 : f32 = mix(mix(hash3(p + vec3 < f32 > (0.0, 0.0, 1.0)), hash3(p + vec3 < f32 > (1.0, 0.0, 1.0)), f.x),
  mix(hash3(p + vec3 < f32 > (0.0, 1.0, 1.0)), hash3(p + vec3 < f32 > (1.0, 1.0, 1.0)), f.x), f.y);

  return mix(mixed1, mixed2, f.z);
}

fn noise(x : vec3f) -> f32 {
  // return 0.2;
    return (noise3(x) + noise3(x + vec3<f32>(11.5, 11.5, 11.5))) / 2.0;
}

@fragment
fn main(vertex : VertexOutput) -> @location(0) vec4f {
  var coord = (vertex.coord + 1.0) / 2.0;
  coord *= 2.0;
  let n : f32 = noise(vec3f (coord.x, coord.y, uniforms.time_since_start));
  var v : f32 = sin(6.28 * 10.*n);
  v = smoothstep(1., 0., 0.5 * abs(v) / fwidth(v));

  let test : f32 = uniforms.time_since_start;
    //let n: f32 = noise(vec3f(coord.x, coord.y, uniforms.time_since_start));
    //var v:f32 = sin(6.28*10.*n);
    //v = smoothstep(1.,0.,0.5*abs(v)/fwidth(v));
    return vec4f(v * (.5+.5*sin(12.*n+vec4(0,2.1,-2.1,0))));
  // return vec4(test, 0.0, 0.0, 1.0);
}
