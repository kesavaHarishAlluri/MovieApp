<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Mini Prime Video</title>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial; margin:0; background:#0f1720; color:#e6eef6; }
    header { background: linear-gradient(90deg,#071028,#0b2740); padding:16px 32px; display:flex; align-items:center; gap:16px; }
    .logo { font-weight:700; font-size:20px; color:#ffd166; }
    .container { padding:24px 32px; }
    .grid { display:grid; grid-template-columns: repeat(auto-fill,minmax(180px,1fr)); gap:18px; margin-top:16px; }
    .card { background:#0b1a2a; border-radius:8px; overflow:hidden; cursor:pointer; transition:transform .12s ease; }
    .card:hover { transform:translateY(-6px); }
    .thumb { height:110px; background:#092034; display:flex; align-items:center; justify-content:center; color:#88b7d3; font-size:14px; }
    .title { padding:10px; font-size:14px; }
    .playerArea { margin-top:22px; background:#071423; padding:16px; border-radius:8px; }
    .video-title { font-size:18px; margin-bottom:8px; }
    .controls { margin-top:8px; display:flex; gap:8px; align-items:center; }
    .btn { background:#1f6f8b; padding:8px 12px; border-radius:6px; color:white; border:none; cursor:pointer; }
    .meta { color:#9fb6c8; font-size:13px; }
    footer { padding:16px 32px; color:#9fb6c8; font-size:13px; text-align:center; margin-top:28px; }
  </style>
</head>
<body>
  <header>
    <div class="logo">MiniPrime</div>
    <div class="logo">Movies</div>
    <div class="logo">Kids</div>
   <div class="logo">Telugu</div>
    <div style="flex:1"></div>
    <nav class="meta">Home • Movies • Series</nav>
  </header>

  <div class="container">
    <h1 style="margin:0 0 8px 0;">Featured</h1>
    <div class="meta">Click a thumbnail to load into player.</div>

    <div id="gallery" class="grid">
      <!-- Hard-coded sample items; replace thumbnail/videoUrl as needed -->
      <div class="card" data-title="Sample Movie 1" data-src="/videos/sample1.mp4">
        <div class="thumb">Thumbnail 1</div>
        <div class="title">Sample Movie 1<br/><span class="meta">1h 42m • Action</span></div>
      </div>

      <div class="card" data-title="Sample Movie 2" data-src="/videos/sample2.mp4">
        <div class="thumb">Thumbnail 2</div>
        <div class="title">Sample Movie 2<br/><span class="meta">2h 04m • Drama</span></div>
      </div>

      <div class="card" data-title="Sample Clip" data-src="/videos/sample-clip.mp4">
        <div class="thumb">Clip</div>
        <div class="title">Sample Clip<br/><span class="meta">0h 03m • Trailer</span></div>
      </div>

      <div class="card" data-title="Local Hosted Video" data-src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4">
        <div class="thumb">Big Buck Bunny</div>
        <div class="title">Big Buck Bunny (public sample)<br/><span class="meta">10m • Family</span></div>
      </div>
    </div>

    <div id="player" class="playerArea" style="display:none;">
      <div class="video-title" id="videoTitle">Title</div>
      <video id="mainVideo" controls width="100%" style="max-height:480px; background:black;">
        <source id="videoSource" src="" type="video/mp4"/>
        Your browser does not support HTML5 video.
      </video>

      <div class="controls">
        <button class="btn" id="playPause">Play / Pause</button>
        <button class="btn" id="muteBtn">Mute/Unmute</button>
        <div style="flex:1"></div>
        <span class="meta" id="videoMeta">Duration: —</span>
      </div>
    </div>

  </div>

  <footer>
    This is a demo UI. Replace `/videos/*.mp4` links with actual hosted video files (static files under `webapp/videos/` or a CDN).
  </footer>

  <script>
    (function(){
      const gallery = document.getElementById('gallery');
      const player = document.getElementById('player');
      const mainVideo = document.getElementById('mainVideo');
      const videoSource = document.getElementById('videoSource');
      const videoTitle = document.getElementById('videoTitle');
      const videoMeta = document.getElementById('videoMeta');
      const playPause = document.getElementById('playPause');
      const muteBtn = document.getElementById('muteBtn');

      function loadVideo(title, src) {
        videoTitle.textContent = title;
        videoSource.src = src;
        mainVideo.load();
        player.style.display = 'block';
        videoMeta.textContent = 'Loading...';
        mainVideo.onloadedmetadata = function() {
          const mins = Math.floor(mainVideo.duration / 60);
          const secs = Math.floor(mainVideo.duration % 60).toString().padStart(2,'0');
          videoMeta.textContent = 'Duration: ' + mins + 'm ' + secs + 's';
        };
      }

      gallery.querySelectorAll('.card').forEach(card => {
        card.addEventListener('click', function(){
          const title = this.getAttribute('data-title');
          const src = this.getAttribute('data-src');
          loadVideo(title, src);
        });
      });

      playPause.addEventListener('click', function(){
        if (mainVideo.paused) mainVideo.play(); else mainVideo.pause();
      });

      muteBtn.addEventListener('click', function(){
        mainVideo.muted = !mainVideo.muted;
        muteBtn.textContent = mainVideo.muted ? 'Unmute' : 'Mute';
      });

      // Load first item automatically
      const first = gallery.querySelector('.card');
      if (first) {
        first.click();
      }
    })();
  </script>
</body>
</html>
