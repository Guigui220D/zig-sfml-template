const std = @import("std");
const sfml = @import("zig-sfml-wrapper/build.zig");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "game",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = mode,
    });
    sfml.link(exe);
    //exe.addIncludePath("csfml/include/");
    //exe.addLibraryPath("csfml/lib/msvc/");
    // TODO: use the zig package manager?
    exe.addAnonymousModule("sfml", .{ .source_file = .{ .path = "zig-sfml-wrapper/src/sfml/sfml.zig" } });

    const run = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the game");
    run_step.dependOn(&run.step);
}
