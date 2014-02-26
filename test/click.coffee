target = null

beforeEach ->
  target = null

describe 'Click Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onClick').andCallFake -> target = @
    fixture """
      <div id="parent">
        <div id="test" data-on-click="MyLib.onClick">
          <div id="child">Test</div>
        </div>
      </div>
      """

  it 'should handle clicks on the element with the attribute', ->
    $('#test').click()
    expect(MyLib.onClick).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should handle clicks on a child element', ->
    $('#child').click()
    expect(MyLib.onClick).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should ignore clicks on a parent element', ->
    $('#parent').click()
    expect(MyLib.onClick).not.toHaveBeenCalled()

  it 'should ignore clicks after destroy() is executed', ->
    $.fastbinder.destroy()
    $('#parent').click()
    expect(MyLib.onClick).not.toHaveBeenCalled()
