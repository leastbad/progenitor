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
    this.previouslineData = null
    this.previousareaData = null
    this.chart = new Chartist.Line(this.element, this.dataValue, {
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
    this.chart.on('draw', data => {
      if (data.type === 'line' || data.type === 'area') {
        data.element.animate({
          d: {
            begin: 2000 * data.index,
            dur: 2000,
            from:
              this[`previous${data.type}Data`] ||
              data.path
                .clone()
                .scale(1, 0)
                .translate(0, data.chartRect.height())
                .stringify(),
            to: data.path.clone().stringify(),
            easing: Chartist.Svg.Easing.easeOutQuint
          }
        })
        this[`previous${data.type}Data`] = data.path.clone().stringify()
      }
    })
  }

  dataValueChanged () {
    this.chart.update(this.dataValue)
  }
}
