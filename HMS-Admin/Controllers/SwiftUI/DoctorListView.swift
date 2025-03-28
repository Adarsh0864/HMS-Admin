//
//  DoctorListView.swift
//  HMS-Admin
//
//  Created by RITIK RANJAN on 27/03/25.
//

import SwiftUI

struct DoctorListView: View {

    // MARK: Internal

    var delegate: DoctorsHostingController?

    var filteredDoctors: [Staff] = []

    var body: some View {

        ZStack {
            // Background color that covers the entire screen
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            // Main content
            VStack(alignment: .leading, spacing: 0) {
                ScrollView {
                    HStack(spacing: 12) {
                        DoctorStatCard(
                            title: "Total Doctors",
                            value: "0",
                            icon: "stethoscope",
                            color: .blue
                        )

                        DoctorStatCard(
                            title: "Active",
                            value: "0",
                            icon: "checkmark.circle",
                            color: .green
                        )

                        DoctorStatCard(
                            title: "On Leave",
                            value: "0",
                            icon: "moon.fill",
                            color: .orange
                        )
                    }
                    .padding(.horizontal)
                    VStack(spacing: 16) {
                        ForEach(filteredDoctors, id: \.id) { doctor in
                            DoctorCard(doctor: doctor)
                        }

                        Color.clear.frame(height: 20)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    // MARK: Private

    @State private var searchText = ""
    @State private var showingAddDoctorView = false
}

struct DoctorCard: View {
    let doctor: Staff

    var body: some View {
        NavigationLink(destination: DoctorProfileView(doctor: doctor)) {
            HStack(spacing: 12) {
                // Profile image
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(.systemGray3))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    // Name
                    Text(doctor.fullName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)

                    // Department and specialization
                    Text(doctor.department)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)

                    Text(doctor.specializations.joined(separator: ", "))
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                }

                Spacer()

                // Status indicator - small dot instead of badge for cleaner list
                Circle()
                    .fill(doctor.onLeave ? Color.orange : Color.green)
                    .frame(width: 10, height: 10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
        }
    }
}
