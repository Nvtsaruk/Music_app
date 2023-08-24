protocol Coordinator {
    func start()
}
protocol CoordinatorDelegate: AnyObject {
    func setCoordinator(_ coordinator: Coordinator)
}
