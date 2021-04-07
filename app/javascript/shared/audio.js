export const play = src => {
  if (document.body.hasAttribute('data-audio-unlocked')) {
    document.audio.addEventListener('canplaythrough', canplaythrough)
    if (src) document.audio.src = src
    document.audio.play()
  }
}

const canplaythrough = () => {
  document.audio.removeEventListener('canplaythrough', canplaythrough)
  document.audio.play()
}
