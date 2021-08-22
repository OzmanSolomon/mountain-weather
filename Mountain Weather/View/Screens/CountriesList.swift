//
//  Weather.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI
import Combine

struct WeatherListList: View {
    
    @State private var countriesSearch = CountriesSearch()
    @State private(set) var countries: Loadable<LazyList<Weather>>
 
    @State private var canRequestPushPermission: Bool = false
   
    @Environment(\.locale) private var locale: Locale
    private let localeContainer = LocaleReader.Container()
    
 
    init(countries: Loadable<LazyList<Weather>> = .notRequested) {
        self._countries = .init(initialValue: countries)
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                self.content
                    .navigationBarItems(trailing: self.permissionsButton)
                    .navigationBarTitle("Countries")
                    .navigationBarHidden(self.countriesSearch.keyboardHeight > 0)
                    .animation(.easeOut(duration: 0.3))
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        }
        .modifier(LocaleReader(container: localeContainer))
          }
    
    private var content: AnyView {
        switch countries {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(last, _): return AnyView(loadingView(last))
        case let .loaded(countries): return AnyView(loadedView(countries, showSearch: true, showLoading: false))
        case let .failed(error): return AnyView(failedView(error))
        }
    }
    
    private var permissionsButton: some View {
        Group {
            if canRequestPushPermission {
                Button(action: requestPushPermission, label: { Text("Allow Push") })
            } else {
                EmptyView()
            }
        }
    }
}

private extension WeatherListList {
    
    struct LocaleReader: EnvironmentalModifier {
        
        /**
         Retains the locale, provided by the Environment.
         Variable `@Environment(\.locale) var locale: Locale`
         from the view is not accessible when searching by name
         */
        class Container {
        
        }
        let container: Container
        
        func resolve(in environment: EnvironmentValues) -> some ViewModifier {
          
            return DummyViewModifier()
        }
        
        private struct DummyViewModifier: ViewModifier {
            func body(content: Content) -> some View {
                // Cannot return just `content` because SwiftUI
                // flattens modifiers that do nothing to the `content`
                content.onAppear()
            }
        }
    }
}

// MARK: - Side Effects

private extension WeatherListList {
    func reloadCountries() {
       
    }
    
    func requestPushPermission() {
      
    }
}

// MARK: - Loading Content

private extension WeatherListList {
    var notRequestedView: some View {
        Text("").onAppear(perform: reloadCountries)
    }
    
    func loadingView(_ previouslyLoaded: LazyList<Weather>?) -> some View {
        if let countries = previouslyLoaded {
            return AnyView(loadedView(countries, showSearch: true, showLoading: true))
        } else {
            return AnyView(ActivityIndicatorView().padding())
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            self.reloadCountries()
        })
    }
}

// MARK: - Displaying Content

private extension WeatherListList {
    func loadedView(_ countries: LazyList<Weather>, showSearch: Bool, showLoading: Bool) -> some View {
        VStack {
          
                ActivityIndicatorView().padding()
          
        }.padding(.bottom, bottomInset)
    }
    
  
    var bottomInset: CGFloat {
        if #available(iOS 14, *) {
            return 0
        } else {
            return countriesSearch.keyboardHeight
        }
    }
}

// MARK: - Search State

extension WeatherListList {
    struct CountriesSearch {
        var searchText: String = ""
        var keyboardHeight: CGFloat = 0
    }
}

 

#if DEBUG
//struct CountriesList_Previews: PreviewProvider {
//    static var previews: some View {
//        CountriesList(countries: .loaded(Country.mockedData.lazyList))
//            .inject(.preview)
//    }
//}
#endif
