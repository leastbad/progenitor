import { Controller } from 'stimulus'
import Chartist from 'chartist'
import 'chartist-plugin-tooltips'

export default class extends Controller {
  initialize () {
    var chart = new Chartist.Bar(
      this.element,
      {
        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        series: [
          [1, 5, 2, 5, 4, 3],
          [2, 3, 4, 8, 1, 2]
        ]
      },
      {
        low: 0,
        showArea: true,
        plugins: [Chartist.plugins.tooltip()],
        axisX: {
          position: 'end'
        },
        axisY: {
          showGrid: false,
          showLabel: false,
          offset: 0
        }
      }
    )

    chart.on('draw', function (data) {
      if (data.type === 'line' || data.type === 'area') {
        data.element.animate({
          d: {
            begin: 2000 * data.index,
            dur: 2000,
            from: data.path
              .clone()
              .scale(1, 0)
              .translate(0, data.chartRect.height())
              .stringify(),
            to: data.path.clone().stringify(),
            easing: Chartist.Svg.Easing.easeOutQuint
          }
        })
      }
    })
  }
}
