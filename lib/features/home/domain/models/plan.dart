class Plan {
  final String id;
  final String type;
  final double returns;
  final String status;
  final double minInvestment;
  final String duration;
  final String description;
  final List<String> benefits;
  final Map<String, double> historicalPerformance;

  Plan({
    required this.id,
    required this.type,
    required this.returns,
    required this.status,
    required this.minInvestment,
    required this.duration,
    required this.description,
    required this.benefits,
    required this.historicalPerformance,
  });

  // Sample data for demonstration
  static List<Plan> samplePlans = [
    Plan(
      id: '1',
      type: 'Growth Fund',
      returns: 12.5,
      status: 'Active',
      minInvestment: 1000,
      duration: '12 months',
      description: 'A balanced investment plan focused on long-term capital appreciation through diversified portfolio management.',
      benefits: ['Professional Management', 'Portfolio Diversification', 'Regular Performance Updates'],
      historicalPerformance: {
        '2023': 12.5,
        '2022': 11.8,
        '2021': 13.2,
      },
    ),
    Plan(
      id: '2',
      type: 'Income Fund',
      returns: 8.75,
      status: 'Active',
      minInvestment: 500,
      duration: '6 months',
      description: 'A conservative investment plan designed to provide regular income through fixed-income securities.',
      benefits: ['Regular Income', 'Lower Risk', 'Flexible Investment Options'],
      historicalPerformance: {
        '2023': 8.75,
        '2022': 8.2,
        '2021': 8.5,
      },
    ),
    Plan(
      id: '3',
      type: 'High Yield Fund',
      returns: 15.0,
      status: 'Active',
      minInvestment: 2000,
      duration: '24 months',
      description: 'An aggressive investment plan targeting higher returns through strategic market opportunities.',
      benefits: ['Higher Returns', 'Market Opportunities', 'Expert Management'],
      historicalPerformance: {
        '2023': 15.0,
        '2022': 14.5,
        '2021': 16.2,
      },
    ),
  ];
}