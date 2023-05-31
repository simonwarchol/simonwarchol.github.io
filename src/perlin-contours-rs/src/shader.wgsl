struct VertexInput {
    @builtin(vertex_index) vertex_index: u32,
};

struct Uniforms {
    time_since_start: f32,
    window_width: f32,
    window_height: f32
};

@group(0)
@binding(0)
var<uniform> uniforms: Uniforms;

struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) coord: vec2<f32>,
};

var<private> ns : f32;

fn hash33(p: vec3<f32>) -> vec3<f32> {

    // Faster, but doesn't disperse things quite as nicely as the block below it. However, when framerate
    // is an issue, and it often is, this is the one to use. Basically, it's a tweaked amalgamation I put
    // together, based on a couple of other random algorithms I've seen around... so use it with caution,
    // because I make a tonne of mistakes. :)
    let n: f32 = sin(dot(p, vec3<f32>(7., 157., 113.)));
    return fract(vec3<f32>(2097152., 262144., 32768.)*n)*2. - vec3<f32>(1., 1., 1.); // return fract(vec3<f32>(64., 8., 1.)*32768.0*n)*2.-vec3<f32>(1., 1., 1.);

    // I'll assume the following came from IQ.
    //p = vec3<f32>( dot(p, vec3<f32>(127.1, 311.7, 74.7)), dot(p, vec3<f32>(269.5, 183.3, 246.1)),
    //          dot(p, vec3<f32>(113.5, 271.9, 124.6)));
    //return (fract(sin(p)*43758.5453)*2. - vec3<f32>(1., 1., 1.));
}

fn tetraNoise(pp: vec3<f32>) -> f32 {

    // Skewing the cubic grid, then determining the first vertice and fractional position.
    var i: vec3<f32> = floor(pp + dot(pp, vec3<f32>(1./3.)));
    var p = pp - (i - dot(i, vec3<f32>(1./6.)));


    // Breaking the skewed cube into tetrahedra with partitioning planes, then determining which side of the
    // intersecting planes the skewed point is on. Ie: Determining which tetrahedron the point is in.
    var i1: vec3<f32> = step(p.yzx, p);
    var i2: vec3<f32> = max(i1, vec3<f32>(1., 1., 1.) - i1.zxy);

    i1 = min(i1, vec3<f32>(1., 1., 1.) - i1.zxy);

    // Using the above to calculate the other three vertices -- Now we have all four tetrahedral vertices.
    // Technically, these are the vectors from "p" to the vertices, but you know what I mean. :)
    var p1: vec3<f32> = p - i1 + vec3<f32>(1./6., 1./6., 1./6.);
    var p2: vec3<f32> = p - i2 + vec3<f32>(1./3., 1./3., 1./3.);
    var p3: vec3<f32> = p - vec3<f32>(.5, .5, .5);


    // 3D simplex falloff - based on the squared distance from the fractional position "p" within the
    // tetrahedron to the four vertice points of the tetrahedron.
    var vv: vec4<f32> = vec4<f32>(dot(p, p), dot(p1, p1), dot(p2, p2), dot(p3, p3));
    var v: vec4<f32> = max(.5 - vv, vec4<f32>(0., 0., 0., 0.));

//
//    // Dotting the fractional position with a random vector, generated for each corner, in order to determine
//    // the weighted contribution distribution... Kind of. Just for the record, you can do a non-gradient, value
//    // version that works almost as well.
    var d: vec4<f32> = vec4<f32>(dot(p, hash33(i)), dot(p1, hash33(i + i1)), dot(p2, hash33(i + i2)), dot(p3, hash33(i + vec3<f32>(1., 1., 1.))));

//
//    // Simplex noise... Not really, but close enough. :)
    return clamp(dot(d, v*v*v*8.)*1.732 + .5, 0., 1.); // Not sure if clamping is necessary. Might be overkill.

}


//float sFract(float x, float sm){
//
//    // Extra smoothing factor. "1" is the norm.
//    const float sf = 1.;
//
//    // The hardware "fwidth" is cheap, but you could take the expensive route and
//    // calculate it by hand if more quality was required.
//    vec2 u = vec2(x, fwidth(x)*sf*sm);
//
//    // Ollj's original formula with a transcendental term omitted.
//    u.x = fract(u.x);
//    u += (1. - 2.*u)*step(u.y, u.x);
//    return clamp(1. - u.x/u.y, 0., 1.); // Cos term ommitted.
//}
//

fn sFract(x: f32, sm: f32) -> f32 {
    let sf: f32 = 1.0;
    var u: vec2<f32> = vec2<f32>(x, abs(fwidth(x))*sf*sm);
    u.x = 1.0;
    u = u + (1.0 - 2.0*u)*select(vec2<f32>(1.0, 1.0), vec2<f32>(0.0, 0.0), u.y > u.x);
    return clamp(1.0 - u.x / u.y, 0.0, 1.0);
}

fn sFloor(x: f32) -> f32 {
    return x - sFract(x, 1.);
}

fn rotHue(p: vec3<f32>, a: f32) -> vec3<f32> {

    let cs: vec2<f32> = vec2<f32>(sin(1.570796 + a), sin(a));

    let hr: mat3x3<f32> = mat3x3<f32>(vec3<f32>(0.299, 0.587, 0.114), vec3<f32>(0.299, 0.587, 0.114), vec3<f32>(0.299, 0.587, 0.114)) +
                          mat3x3<f32>(vec3<f32>(0.701, -0.587, -0.114), vec3<f32>(-0.299, 0.413, -0.114), vec3<f32>(-0.300, -0.588, 0.886)) * cs.x +
                          mat3x3<f32>(vec3<f32>(0.168, 0.330, -0.497), vec3<f32>(-0.328, 0.035, 0.292), vec3<f32>(1.250, -1.050, -0.203)) * cs.y;
    var prod: vec3<f32> =  p*hr;
    return vec3<f32>(clamp(prod.x,0.0,1.0), clamp(prod.y,0.0,1.0), clamp(prod.z,0.0,1.0));
}


fn func(p: vec2<f32>) -> f32 {

    // The noise value.
    var n: f32 = tetraNoise(vec3<f32>(p.x*4.0, p.y*4.0, 0.0) - vec3<f32>(0.0, 0.25, 0.5)*uniforms.time_since_start);

    // A tapering function, similar in principle to a smooth combine. Used to mutate or shape
    // the value above. This one tapers it off into an oval shape and punches in a few extra holes.
    // Airtight uses a more interesting triangular version in his "Cartoon Fire" shader.
    let taper: f32 = 0.1 + dot(p, p*vec2<f32>(0.35, 1.0));
    n = max(n - taper, 0.0) / max(1.0 - taper, 0.0001);

    // Saving the noise value prior to palettization. Used for a bit of gradient highlighting.
    ns = n;

    // I remember reasoning to myself that the following would take a continuous function ranging
    // from zero to one, then palettize it over "palNum" discreet values between zero and one
    // inclusive. It seems to work, but if my logic is lacking (and it often is), feel free to
    // let me know. :)
    const palNum: f32 = 9.0;
    // The range should strictly fall between zero and one, but for some crazy reason, numbers fall
    // outside the range, so I've had to clamp it. I know the computer is never wrong, so I'm
    // probably overlooking something. Having said that, I don't trust the GPU "fract" function much.
    //return clamp(sFloor(n*(palNum - .001))/(palNum - 1.), 0., 1.);
    return n*0.25 + clamp(sFloor(n*(palNum - 0.001))/(palNum - 1.0), 0.0, 1.0)*0.75;
}









@vertex
fn vs_main(in: VertexInput) -> VertexOutput {

    var vertices = array<vec2<f32>, 3>(
        vec2<f32>(-1., 1.),
        vec2<f32>(3.0, 1.),
        vec2<f32>(-1., -3.0),
    );
    var out: VertexOutput;
    out.coord =vertices[in.vertex_index];
    out.position = vec4<f32>(out.coord, 0.0, 1.0);
    return out;
}

@fragment
fn fs_main(vertex: VertexOutput) -> @location(0) vec4<f32> {
     // Function value.
    var u: vec2<f32> =vertex.coord;
    var f: f32 = func(vertex.coord);
    var delta: f32 = 0.01;
    let ssd: f32 = ns;
    let e:vec2<f32> = vec2(1.5/uniforms.window_height, 0.0);
    var fxl: f32 = func(vertex.coord + vec2<f32>(delta,delta));;
    var fxr: f32 = func(vertex.coord + vec2<f32>(-delta,delta));
    var fyt: f32 = func(vertex.coord + vec2<f32>(delta,-delta));
    var fyb: f32 = func(vertex.coord + vec2<f32>(-delta,-delta));
    var col: vec3<f32> = vec3<f32>(f*0.3,f*0.3,f*0.3);
    col *= max(1. - (abs(fxl - fxr) + abs(fyt - fyb))*5., 0.);
    fxl = func(u + vec2<f32>(-delta,delta));
    fyt = func(u + vec2<f32>(delta,-delta));
    col += vec3<f32>(1.0, 1.0, 1.0)*(max(f - fyt, 0.) + max(f - fxl, 0.))*ssd*10.;
    var clamped_col = vec3<f32>(clamp(col.x,0.0,1.0),clamp(col.y,0.0,1.0),clamp(col.z,0.0,1.0));
    var sqrt_col = sqrt(clamped_col);
    return vec4<f32>(sqrt_col.x,sqrt_col.y,sqrt_col.z,1.0);
//    col = vec4<f32>(sqrt(clamp(col, vec3<f32>(0.0, 0.0, 0.0), vec3<f32>(1.0, 1.0, 1.0)));

//    var col: vec3<f32> = pow(min(vec3<f32>(1.5, 1.0, 1.0)*(f*.7 + ssd*.35), 1.), vec3<f32>(1.0, 2.0, 10.0)*2.0) + .01;


//    return vec4<f32>(((vertex.coord.x + 1.0 ) / 2.0),((vertex.coord.y + 1.0 ) / 2.0), 0.0, 1.0);
}