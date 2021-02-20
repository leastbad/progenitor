import { Controller } from 'stimulus'
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'

export default class extends Controller {
  static values = { events: Array }

  initialize () {
    this.addNewEventModalEl = document.getElementById('modal-new-event')
    this.editEventModalEl = document.getElementById('modal-edit-event')
    this.newEventTitleInput = document.getElementById('eventTitleAdd')
    this.editEventTitleInput = document.getElementById('eventTitleEdit')
    this.addNewEventFormEl = document.getElementById('addNewEventForm')
    this.editEventFormEl = document.getElementById('editEventForm')
    this.editEventEl = document.getElementById('editEvent')
    this.deleteEventEl = document.getElementById('deleteEvent')
    this.dateStartAdd = document.getElementById('dateStartAdd')
    this.dateEndAdd = document.getElementById('dateEndAdd')
    this.dateStartEdit = document.getElementById('dateStartEdit')
    this.dateEndEdit = document.getElementById('dateEndEdit')
  }

  connect () {
    const addNewEventModal = new bootstrap.Modal(this.addNewEventModalEl)
    const editEventModal = new bootstrap.Modal(this.editEventModalEl)

    let currentId = null

    const calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin, interactionPlugin],
      selectable: true,
      initialView: 'dayGridMonth',
      initialDate: this.formatDate(new Date()),
      editable: true,
      events: this.eventsValue,
      fixedWeekCount: false,
      dateClick: info => {
        this.dateStartAdd.value = info.dateStr
        this.dateEndAdd.value = info.dateStr
        this.newEventTitleInput.value = ''
        if (info.date.setHours(0, 0, 0, 0) < this.today) return
        addNewEventModal.show()
        this.addNewEventModalEl.addEventListener('shown.bs.modal', () =>
          this.newEventTitleInput.focus()
        )
      },
      eventClick: info => {
        currentId = info.event.id
        const event = calendar.getEventById(currentId)
        this.editEventTitleInput.value = info.event.title
        this.dateStartEdit.value = this.formatDate(event._instance.range.start)
        this.dateEndEdit.value = this.formatDate(event._instance.range.end)
        editEventModal.show()
        this.editEventModalEl.addEventListener('shown.bs.modal', () =>
          this.editEventTitleInput.focus()
        )
      }
    })
    calendar.render()

    this.addNewEventFormEl.addEventListener('submit', event => {
      event.preventDefault()
      calendar.addEvent({
        id: parseInt(Math.random() * 10000), // this should be a unique id from your back-end or API
        title: this.newEventTitleInput.value,
        start: this.dateStartAdd.value,
        end: this.dateEndAdd.value,
        className: 'bg-secondary',
        draggable: true
      })
      addNewEventModal.hide()
    })

    this.editEventEl.addEventListener('click', event => {
      event.preventDefault()
      const editEvent = calendar.getEventById(currentId)
      editEvent.setProp('title', this.editEventTitleInput.value)
      editEvent.setStart(this.dateStartEdit.value)
      editEvent.setEnd(this.dateEndEdit.value)
      editEventModal.hide()
    })

    this.deleteEventEl.addEventListener('click', event => {
      event.preventDefault()
      calendar.getEventById(currentId).remove()
      editEventModal.hide()
    })
  }

  formatDate (date) {
    return date.toISOString().split('T')[0]
  }

  get today () {
    const now = new Date()
    return new Date(
      Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate())
    ).setHours(0, 0, 0, 0)
  }
}
