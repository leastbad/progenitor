import { Controller } from 'stimulus'
import Chartist from 'chartist'
import 'chartist-plugin-tooltips'

export default class extends Controller {
  static values = {
    data: Object,
    low: Number,
    showArea: Boolean,
    tooltip: Boolean
  }

  initialize () {
    this.chart = new Chartist.Bar(this.element, this.dataValue, {
      low: this.lowValue,
      showArea: this.showAreaValue,
      plugins: this.tooltipValue ? [Chartist.plugins.tooltip()] : [],
      axisX: {
        position: 'end'
      },
      axisY: {
        showGrid: false,
        showLabel: false,
        offset: 0
      }
    })

    this.chart.on('draw', function (data) {
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

  dataValueChanged () {
    this.chart.update(this.dataValue)
  }
}
