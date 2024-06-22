const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
const fs = require("fs");

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

app.use(express.static("public"));

let videoChunks = [];
let tempFilename;

app.use(express.json());
app.get("/data", (req, res) => {
  res.send(videoChunks);
});

io.on("connection", (socket) => {
  console.log("a user connected");

  tempFilename = `temp-${Date.now()}.webm`;
  const writeStream = fs.createWriteStream(tempFilename, { flags: "a" });

  socket.on("videoChunk", (chunk) => {
    console.log("Received video chunk of size:", chunk.length);
    io.emit("videoChunk", chunk);
    videoChunks.push(chunk.buffer);
    console.log(chunk.buffer);

    writeStream.write(
      Buffer.from({
        type: "Buffer",
        data: videoChunks,
      })
    ); // Tulis chunk langsung ke stream
  });

  socket.on("disconnect", async () => {
    console.log("user disconnected");

    //   // Tutup stream saat pengguna terputus
    //   writeStream.end(async () => {
    //     const outputFilename = `video-${Date.now()}.webm`;

    //     try {
    //       // Menggunakan ffmpeg-concat untuk menggabungkan chunk video
    //       await ffmpegConcat({
    //         output: outputFilename,
    //         videos: [tempFilename]
    //       });
    //       console.log(`Video saved as ${outputFilename}`);
    //       // Hapus file sementara
    //       //fs.unlinkSync(tempFilename);
    //     } catch (error) {
    //       console.error('Error processing video:', error.message);
    //     }
    //   });
  });
});

server.listen(3000, () => {
  console.log("listening on *:3000");
});
