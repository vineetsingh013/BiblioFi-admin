//
//  Stats.swift
//  BiblioFi-admin
//
//  Created by Keshav Lohiya on 10/07/24.
//

import Foundation
import SwiftUI

struct LibraryStatsView: View {
    let libraryStats: LibraryStats
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                StatCardView(title: "Total Users", value: "\(libraryStats.totalUsers)")
                StatCardView(title: "Total Books", value: "\(libraryStats.totalBooks)")
                StatCardView(title: "Fine Due", value: "$\(libraryStats.fineDue)")
            }
            .padding(.horizontal)
            
            HStack(spacing: 20) {
                UserActivityView(userActivity: libraryStats.userActivity)
                MonthlyRevenueView(monthlyRevenue: libraryStats.monthlyRevenue)
            }
            .padding(.horizontal)
            
            TrendingBooksView(trendingBooks: libraryStats.trendingBooks)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct StatCardView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
        }
        .frame(width: 160, height: 100) // Adjust width and height
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
struct UserActivityView: View {
    let userActivity: [String: Int]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("User Activity Trends")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            Text("Library Usage by Day")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
            BarChartView(data: userActivity)
                .frame(height: 240)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
struct MonthlyRevenueView: View {
    let monthlyRevenue: [String: Double]
    private let colors: [Color] = [.blue, .green, .orange, .purple, .red]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Monthly Revenue Distribution")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            Text("Revenue Generation by Month")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
            
            HStack {
                PieChartView(data: monthlyRevenue, colors: colors)
                    .frame(width: 200, height: 200)
                    .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Array(monthlyRevenue.keys.enumerated()), id: \.element) { index, month in
                        HStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(colors[index % colors.count])
                                .frame(width: 20, height: 20)
                            
                            Text("\(month) $\(monthlyRevenue[month]!, specifier: "%.2f") revenue")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 2)
                    }
                }
                .padding(.leading, 10)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}


struct TrendingBooksView: View {
    let trendingBooks: [TrendingBook]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Top Trending Books")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            Text("Most issued book of the week")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
                ForEach(trendingBooks, id: \.category) { book in
                    TrendingBookView(book: book)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct TrendingBookView: View {
    let book: TrendingBook
    
    var body: some View {
        VStack {
            Text(book.category)
                .font(.title)
                .fontWeight(.bold)
            Text("Book issued: \(book.issuedCount)")
            Text("% of total: \(book.percentageOfTotal, specifier: "%.1f")")
        }
        .frame(width: 240, height: 160)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
struct BarChartView: View {
    let data: [String: Int]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 12) { // Increase spacing
                ForEach(data.keys.sorted(), id: \.self) { key in
                    let value = data[key] ?? 0
                    VStack {
                        Text("\(value)")
                            .font(.caption)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: (geometry.size.width / CGFloat(data.count)) - 12, height: CGFloat(value)) // Adjust width
                        Text(key)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

struct PieChartView: View {
    let data: [String: Double]
    let colors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            let total = data.values.reduce(0, +)
            let slices = data.map { (label, value) in
                (label, value / total)
            }
            let startAngle: Angle = .degrees(-90)
            
            ZStack {
                ForEach(Array(slices.enumerated()), id: \.element.0) { index, slice in
                    PieSliceView(startAngle: startAngle + Angle(degrees: Double(slices.prefix(index).map(\.1).reduce(0, +) * 360)),
                                 endAngle: startAngle + Angle(degrees: Double(slices.prefix(index + 1).map(\.1).reduce(0, +) * 360)),
                                 color: colors[index % colors.count])
                }
            }
        }
    }
}

struct PieSliceView: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    
    var body: some View {
        Path { path in
            let center = CGPoint(x: 100, y: 100)
            path.move(to: center)
            path.addArc(center: center,
                        radius: 100,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
        }
        .fill(color)
        
    }
}
