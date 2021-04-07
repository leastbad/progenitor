import { Controller } from 'stimulus'
import Chartist from 'chartist'
import 'chartist-plugin-tooltips'

const sum = function (a, b) {
  return a + b
}

export default class extends Controller {
  static values = {
    data: Object,
    donut: Boolean,
    donutWidth: Number,
    donutSolid: Boolean,
    fullWidth: Boolean,
    showLabel: Boolean,
    tooltip: Boolean,
    high: Number,
    low: Number,
    startAngle: Number
  }

  initialize () {
    this.chart = new Chartist.Pie(this.element, this.dataValue, {
      labelInterpolationFnc: value => {
        return (
          Math.round((value / this.dataValue.series.reduce(sum)) * 100) + '%'
        )
      },
      low: this.lowValue,
      high: this.highValue,
      donut: this.donutValue,
      donutWidth: this.donutWidthValue,
      donutSolid: this.donutSolidValue,
      fullWidth: this.fullWidthValue,
      showLabel: this.showLabelValue,
      plugins: this.tooltipValue ? [Chartist.plugins.tooltip()] : [],
      startAngle: this.startAngleValue
    })
  }

  dataValueChanged () {
    this.chart.update(this.dataValue)
  }
}
