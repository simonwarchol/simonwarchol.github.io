

struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) coord: vec2<f32>,
};


@vertex
fn main(
  @builtin(vertex_index) VertexIndex : u32
) -> VertexOutput {
  var vertices =  array<vec2f, 3>(
        vec2(-1., 1.),
        vec2(3.0, 1.),
        vec2(-1., -3.0),
    );
    var out: VertexOutput;
    out.coord =vertices[VertexIndex];
    out.position = vec4f(out.coord, 0.0, 1.0);
    var pos = array<vec2f, 3>(
      vec2(0.0, 0.5),
      vec2(-0.5, -0.5),
      vec2(0.5, -0.5)
    );

  return out;
}
