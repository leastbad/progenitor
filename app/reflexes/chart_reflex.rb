# frozen_string_literal: true

class ChartReflex < ApplicationReflex
  def week
    value = {"labels":["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],"series":[[10,30,40,50,70,50,70]]}
    cable_ready.set_dataset_property(selector: "#sales", name: "lineChartDataValue", value: value.to_json)
    morph :nothing
  end
  def month
    value = {"labels":["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],"series":[[30,50,60,70,80,70,100]]}
    cable_ready.set_dataset_property(selector: "#sales", name: "lineChartDataValue", value: value.to_json)
    morph :nothing
  end
end