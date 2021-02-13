import { Controller } from 'stimulus'
import Chartist from 'chartist'

export default class extends Controller {
  initialize () {
    var data = {
      series: [70, 20, 10]
    }

    var sum = function (a, b) {
      return a + b
    }

    new Chartist.Pie(this.element, data, {
      labelInterpolationFnc: function (value) {
        return Math.round((value / data.series.reduce(sum)) * 100) + '%'
      },
      low: 0,
      high: 8,
      donut: true,
      donutWidth: 20,
      donutSolid: true,
      fullWidth: false,
      showLabel: false
    })
  }
}
