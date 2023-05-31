struct VertexInput {
    @builtin(vertex_index) vertex_index: u32,
};

struct Uniforms {
    time_since_start: f32
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
fn fs_main() -> @location(0) vec4<f32> {
    return vec4<f32>(uniforms.time_since_start,1.0, 0.0, 1.0);
}