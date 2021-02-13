import { Controller } from 'stimulus'
import Chartist from 'chartist'
import 'chartist-plugin-tooltips'

export default class extends Controller {
  initialize () {
    new Chartist.Line(
      this.element,
      {
        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        series: [[0, 10, 30, 40, 80, 60, 100]]
      },
      {
        low: 0,
        showArea: true,
        fullWidth: true,
        plugins: [Chartist.plugins.tooltip()],
        axisX: {
          position: 'end',
          showGrid: true
        },
        axisY: {
          showGrid: false,
          showLabel: false,
          labelInterpolationFnc: function (value) {
            return '$' + value / 1 + 'k'
          }
        }
      }
    )
  }
}
