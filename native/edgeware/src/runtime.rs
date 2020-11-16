use std::future::Future;

/// Spawns a task onto the global executor and deteches it.
///
/// There is a global executor that gets lazily initialized on first use.
/// # Examples
///
/// ```
/// runtime::spawn(async {
///     1 + 2
/// });
/// ```
pub fn spawn<T: Send + 'static>(
    future: impl Future<Output = T> + Send + 'static,
) {
    let _ = async_std::task::spawn(future);
}
