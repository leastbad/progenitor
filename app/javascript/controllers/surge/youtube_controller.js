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
    this.width = this.widthValue || 640
    this.height = this.heightValue || 480
  }

  connect () {
    if (!this.hasCodeValue) return
    const player = YouTubePlayer(this.frameTarget, {
      width: this.width,
      height: this.height,
      videoId: this.codeValue
    })
    player.on('ready', e => (this.player = e.target))
    player.on('stateChange', e => (this.playerState = e.data))
  }

  teardown () {
    this.player.destroy()
  }

  play = () => this.player.playVideo()
  pause = () => this.player.pauseVideo()
  stop = () => this.player.stopVideo()
  seek = seconds => this.player.seekTo(seconds)

  get currentTime () {
    return this.player.getCurrentTime()
  }
  get duration () {
    return this.player.getDuration()
  }
  get state () {
    return this.playerState
  }
}
