require 'test_helper'

class ViewerTest < ActionDispatch::IntegrationTest
  setup do
    @time_to_render = 2
  end

  test "Full viewer" do
    visit "/"
    output = capture(:stdout) do
      click_on "full viewer"
      assert has_selector?("#pdfjs_viewer-full")
      assert_equal 1, all("#pdfjs_viewer-full").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "full_viewer.png"
  end

  test "Reduced viewer" do
    visit "/"
    output = capture(:stdout) do
      click_on "reduced viewer"
      assert has_selector?("#pdfjs_viewer-reduced")
      assert_equal 1, all("#pdfjs_viewer-reduced").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "reduced_viewer.png"
  end

  test "Minimal viewer" do
    visit "/"
    output = capture(:stdout) do
      click_on "minimal viewer"
      assert has_selector?("#pdfjs_viewer-minimal")
      assert_equal 1, all("#pdfjs_viewer-minimal").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "minimal_viewer.png"
  end

  test "Using the helper" do
    visit "/"
    output = capture(:stdout) do
      click_on "helper"
      assert has_selector?("#pdfjs_viewer-minimal")
      assert_equal 1, all("#pdfjs_viewer-minimal").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "helper.png"
  end

  test "extra_head is rendered into the head of the viewer" do
    visit "/"
    capture(:stdout) do
      click_on "helper"
      assert_equal "1", find('meta[name="example"]', visible: false)[:content]
    end
  end

  test "pdfjs viewer verbosity is set with ENV variable" do
    begin
      {
        errors: 0,
        warnings: 1,
        infos: 5
      }.each do |level, number|
        ENV["PDFJS_VIEWER_VERBOSITY"] = level.to_s
        capture(:stdout) do
          visit "/"
          click_on "full viewer"
        end
        sleep @time_to_render
        assert_equal number, page.evaluate_script("PDFJS.verbosity")
      end
    ensure
      ENV.delete("PDFJS_VIEWER_VERBOSITY")
    end
  end

  private
  def assert_rendered_pdf(output, screenshot:)
    assert_match(/PDF a0f29a2f4968123b2e931593605583c8/, output)
    page.save_screenshot screenshot, full: true
  end

  def capture(stream)
    stream = stream.to_s
    captured_stream = Tempfile.new(stream)
    stream_io = eval("$#{stream}")
    origin_stream = stream_io.dup
    stream_io.reopen(captured_stream)

    yield

    stream_io.rewind
    return captured_stream.read
  ensure
    captured_stream.close
    captured_stream.unlink
    stream_io.reopen(origin_stream)
  end
end
