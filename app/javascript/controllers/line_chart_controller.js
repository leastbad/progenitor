import { Controller } from 'stimulus'
import Chartist from 'chartist'
import 'chartist-plugin-tooltips'

const interpolations = {
  k: function (value) {
    return '$' + value / 1 + 'k'
  },
  M: function (value) {
    return value / 1 + 'M'
  }
}
export default class extends Controller {
  static values = {
    data: Object,
    low: Number,
    showArea: Boolean,
    fullWidth: Boolean,
    tooltip: Boolean,
    showGridX: Boolean,
    showGridY: Boolean,
    showLabelX: Boolean,
    showLabelY: Boolean,
    interpolation: String
  }
  initialize () {
    new Chartist.Line(this.element, this.dataValue, {
      low: this.lowValue,
      showArea: this.showAreaValue,
      fullWidth: this.fullWidthValue,
      plugins: this.tooltipValue ? [Chartist.plugins.tooltip()] : [],
      axisX: {
        position: 'end',
        showGrid: this.showGridXValue
      },
      axisY: {
        showGrid: this.showGridYValue,
        showLabel: this.showLabelYValue,
        labelInterpolationFnc: interpolations[this.interpolationValue]
      }
    })
  }
}
