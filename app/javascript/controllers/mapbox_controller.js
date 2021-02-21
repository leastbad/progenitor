import { Controller } from 'stimulus'
import L from 'leaflet'

export default class extends Controller {
  initialize () {
    this.config = {
      mapboxToken:
        'pk.eyJ1IjoibGVhc3RiYWQiLCJhIjoiY2tsZGYwanR2M3JqcTMwdDdrdG53dzd3eSJ9.fWOSGtvgbDoOLdXUUaFaoQ',
      mapboxId: 'mapbox/light-v10'
    }

    this.baseLatLng = [37.57, -122.26]
    this.zoom = 10
    this.listings = [
      {
        url: '#',
        latLng: [37.7, -122.41],
        name: 'Call with Jane',
        date: 'Tomorrow at 12:30 PM'
      },
      {
        url: '#',
        latLng: [37.59, -122.39],
        name: 'HackTM conference',
        date: 'In about 5 minutes'
      },
      {
        url: '#',
        latLng: [37.52, -122.29],
        name: 'Marketing event',
        date: 'Today at 1:00 PM'
      },
      {
        url: '#',
        latLng: [37.37, -122.12],
        name: 'Dinner with partners',
        date: 'In 2 hours'
      },
      {
        url: '#',
        latLng: [37.36, -121.94],
        name: 'Interview with Google',
        date: 'In two days at 15:00 PM'
      }
    ]
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

    // modal listing view
    const mapListings = L.map('mapbox').setView(this.baseLatLng, this.zoom)
    L.tileLayer(
      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      {
        attribution:
          'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: config.mapboxId,
        accessToken: config.mapboxToken
      }
    ).addTo(mapListings)

    listings.map(function (listing, index) {
      var popupHtml = `
          <a href="${listing.url}" class="card card-article-wide border-0 flex-column no-gutters no-hover">
              <div class="card-body py-0 d-flex flex-column justify-content-between col-12">
                  <h4 class="h5 fw-normal mb-2">${listing.name}</h4>
                  <div class="d-flex"><div class="icon icon-xs icon-tertiary me-2"><span class="fas fa-clock"></span></div><div class="font-xs text-dark">${listing.date}</div></div>
              </div>
          </a>
      `

      var marker = L.marker(listing.latLng, { icon: icon }).addTo(mapListings)
      marker.bindPopup(popupHtml)
    })
  }
}
