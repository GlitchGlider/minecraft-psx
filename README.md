# Minecraft PS1 (PSX) Shaders

A Minecraft shader pack for originally for both [OptiFine](https://optifine.net/) and [Iris](https://irisshaders.net/) that mimics the look and feel of PlayStation 1 graphics.

## This fork however focuses on running with Iris!

Tested to work with Minecraft 1.20.6-1.21.3, and under research.

The main goal of this fork is to fix some of the buffers rendering incorrectly and to port Distant Horizons support to this specific shader pack.

> [!WARNING]
> Distant Horizons is currently not supported!

## Video Demonstrations

### Video Demonstrations of the Original Shaders (v1.1.0)

<div style="dislpay: inline">
    <a href="https://www.youtube.com/watch?v=6n_WGBEuRGY" target="_blank"><img src="https://img.youtube.com/vi/6n_WGBEuRGY/maxresdefault.jpg" width="300"></a>
    <a href="https://youtu.be/kptqR3g1SQQ" target="_blank"><img src="https://img.youtube.com/vi/kptqR3g1SQQ/maxresdefault.jpg" width="300"></a>
</div>

### Video Demonstration of the Current Shaders (v1.2.0)

[video here]

## Installation

Clone this Git repository (if you want the latest changes), or download the latest zipped release.

Place the cloned repository folder or downloaded zip file in your `shaderpacks` folder.

**※ NOTE:** If you don't know where your `shaderpacks` folder is located, you can open it using the "Shaders Folder" button (OptiFine) or the "Open Shader Pack Folder…" button (Iris) on the bottom left of your shader pack selection screen.

### Older Known Issues

- Texture affine mapping behaviour on Iris does not exactly match that of OptiFine's. All affine mapped textures on Iris warp in the opposite direction compared to OptiFine, though this is not noticeable without comparing the two side-by-side.

- In-universe text (signs, player/entity name tags, etc.) can be difficult, if not nearly impossible to read without zooming (or moving very close to the text in question) due to the mesh vertex distortion effect affecting the mesh that in-universe text is rendered to. Glow ink signs are notable for being the most illegible due to the fact that the glow ink effect is in itself rendered as a secondary mesh behind the already-existing text mesh.
  - Text rendering on UI elements (chat, inventory screens, etc.) is completely unaffected.

## License

Licensed under the [MIT License](https://choosealicense.com/licenses/mit/) and continues to be!
