import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["canvas"]

    connect() {
        const ctx = this.canvasTarget.getContext("2d")

        // Funkce pro generování náhodných dat
        const randomChartData = (n) => {
            const data = []
            for (let i = 0; i < n; i++) {
                data.push(Math.round(Math.random() * 200))
            }
            return data
        }

        const chartColors = {
            primary: '#00D1B2',
            info: '#209CEE',
            danger: '#FF3860'
        }

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['01', '02', '03', '04', '05', '06', '07', '08', '09'],
                datasets: [
                    {
                        label: 'Eknihy',
                        fill: false,
                        borderColor: chartColors.primary,
                        borderWidth: 2,
                        pointBackgroundColor: chartColors.primary,
                        pointRadius: 4,
                        data: randomChartData(9)
                    },
                    {
                        label: 'Ostatní',
                        fill: false,
                        borderColor: chartColors.info,
                        borderWidth: 2,
                        pointBackgroundColor: chartColors.info,
                        pointRadius: 4,
                        data: randomChartData(9)
                    },
                    {
                        label: 'Audio knihy',
                        fill: false,
                        borderColor: chartColors.danger,
                        borderWidth: 2,
                        pointBackgroundColor: chartColors.danger,
                        pointRadius: 4,
                        data: randomChartData(9)
                    }
                ]
            },
            options: {
                maintainAspectRatio: false,
                responsive: true,
                legend: {
                    display: true
                },
                tooltips: {
                    backgroundColor: '#f5f5f5',
                    titleFontColor: '#333',
                    bodyFontColor: '#666',
                    bodySpacing: 4,
                    xPadding: 12,
                    mode: 'nearest',
                    intersect: false,
                    position: 'nearest'
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            fontColor: '#9a9a9a',
                            padding: 20
                        },
                        gridLines: {
                            color: 'rgba(29,140,248,0.1)',
                            zeroLineColor: 'transparent',
                            drawBorder: false
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            fontColor: '#9a9a9a',
                            padding: 20
                        },
                        gridLines: {
                            color: 'rgba(225,78,202,0.1)',
                            zeroLineColor: 'transparent',
                            drawBorder: false
                        }
                    }]
                }
            }
        })
    }
}
