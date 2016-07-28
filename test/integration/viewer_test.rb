require 'test_helper'

class ViewerTest < ActionDispatch::IntegrationTest
  setup do
    @time_to_render = 2
  end

  test "Full viewer" do
    visit "/"
    output = capture(:stdout) do
      click_on "full viewer"
      assert_equal 1, all("#pdfjs_viewer-full").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "full_viewer.png"
  end

  test "Reduced viewer" do
    visit "/"
    output = capture(:stdout) do
      click_on "reduced viewer"
      assert_equal 1, all("#pdfjs_viewer-reduced").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "reduced_viewer.png"
  end

  test "Minimal viewer" do
    visit "/"
    output = capture(:stdout) do
      click_on "minimal viewer"
      assert_equal 1, all("#pdfjs_viewer-minimal").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "minimal_viewer.png"
  end

  test "Using the helper" do
    visit "/"
    output = capture(:stdout) do
      click_on "helper"
      assert_equal 1, all("#pdfjs_viewer-minimal").size
      sleep @time_to_render
    end

    assert_rendered_pdf output, screenshot: SANDBOX_PATH + "helper.png"
  end

  private
  def assert_rendered_pdf(output, screenshot:)
    puts output.scan(/Warning:.+$/)
    assert_match(/PDF d6ea82b9661e58030e99729d198a353a/, output)
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
