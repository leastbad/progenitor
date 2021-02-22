import { Controller } from 'stimulus'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'

export default class extends Controller {
  static values = {
    listings: Array,
    baseLatLng: Array,
    zoom: Number,
    token: String,
    id: String,
    maxZoom: Number
  }

  connect () {
    const icon = L.icon({
      iconUrl: '/marker.svg',
      iconSize: [38, 95], // size of the icon
      shadowSize: [50, 64], // size of the shadow
      iconAnchor: [22, 94], // point of the icon which will correspond to marker's location
      shadowAnchor: [4, 62], // the same for the shadow
      popupAnchor: [-3, -76] // point from which the popup should open relative to the iconAnchor
    })

    const mapListings = L.map(this.element).setView(
      this.baseLatLngValue,
      this.zoomValue
    )
    L.tileLayer(
      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      {
        attribution:
          'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: this.maxZoomValue,
        id: this.idValue,
        accessToken: this.tokenValue
      }
    ).addTo(mapListings)

    this.listingsValue.forEach(listing => {
      const popupHtml = `
        <a href="${listing.url}" class="card card-article-wide border-0 flex-column no-gutters no-hover">
          <div class="card-body py-0 d-flex flex-column justify-content-between col-12">
            <h4 class="h5 fw-normal mb-2">${listing.name}</h4>
            <div class="d-flex">
              <div class="icon icon-xs icon-tertiary me-2"><span class="fas fa-clock"></span></div>
              <div class="font-xs text-dark mw-content">${listing.date}</div>
            </div>
          </div>
        </a>
      `
      const marker = L.marker(listing.latLng, { icon: icon }).addTo(mapListings)
      marker.bindPopup(popupHtml)
    })
  }
}
