import { Controller } from 'stimulus'
import YouTubePlayer from 'youtube-player'

export default class extends Controller {
  static values = {
    code: String,
    width: Number,
    height: Number
  }
  static targets = ['frame']

  initialize () {
    if (!this.hasCodeValue) return
    this.width = this.widthValue || 640
    this.height = this.heightValue || 480
  }

  connect () {
    const player = YouTubePlayer(this.frameTarget, {
      width: this.width,
      height: this.height,
      videoId: this.codeValue
    })
    player.on('ready', e => (this.player = e.target))
  }

  play = () => this.player.playVideo()

  pause = () => this.player.pauseVideo()

  stop = () => this.player.stopVideo()

  seek = seconds => this.player.seekTo(seconds)
}
