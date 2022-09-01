import UIKit

extension UIViewController {

    func setupNavigationImage(_ name :String) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        let logoContainer = UIView(frame: frame)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit

        let image = UIImage(named: name)
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
    }
    
    func showNavigationFor(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)

        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func setupTabBarItem(title: String, imageName: String) {

        tabBarItem = UITabBarItem(title: title,
                                  image: UIImage(named: imageName),
                                  tag: 0)

        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
    }
    
    func setupBackButton() {
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
