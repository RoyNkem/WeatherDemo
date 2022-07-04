//
//  ProgressVIew.swift
//  WeatherDemo
//
//  Created by Roy Aiyetin on 28/04/2022.
//

import SwiftUI

struct LoadingVIew: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProgressVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoadingVIew()
    }
}
