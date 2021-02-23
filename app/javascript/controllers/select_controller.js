import { Controller } from 'stimulus'
import SlimSelect from 'slim-select'

export default class extends Controller {
  connect () {
    const limit = this.data.get('limit')
    const placeholder = this.data.get('placeholder')
    const searchText = this.data.get('no-results')
    const closeOnSelect = this.single
    const allowDeselect = !this.element.required

    this.select = new SlimSelect({
      select: this.element,
      closeOnSelect,
      allowDeselect,
      limit,
      placeholder,
      searchText
    })
  }

  get single () {
    return !this.element.multiple
  }
  get multi () {
    return this.element.multiple
  }

  disconnect () {
    this.select.destroy()
  }
}
