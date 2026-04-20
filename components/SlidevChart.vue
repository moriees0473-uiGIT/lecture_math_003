<script setup>
import { Bar } from 'vue-chartjs'
import { 
  Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale 
} from 'chart.js'

// Chart.js のプラグインを登録
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

const props = defineProps({
  label: { type: String, default: 'データセット' },
  chartData: {
    type: Array,
    default: () => [40, 20, 12, 39, 10]
  }
})

const data = {
  labels: ['January', 'February', 'March', 'April', 'May'],
  datasets: [
    {
      label: props.label,
      backgroundColor: '#42b883',
      data: props.chartData
    }
  ]
}

const options = {
  responsive: true,
  maintainAspectRatio: false
}
</script>

<template>
  <div class="h-80 w-120 mx-auto"> 
    <Bar :data="data" :options="options" />
  </div>
</template>

