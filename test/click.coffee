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
    expect(MyLib.onClick).not.toHaveBeenCalled()
    $('#test').click()
    expect(MyLib.onClick).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should handle clicks on a child element', ->
    expect(MyLib.onClick).not.toHaveBeenCalled()
    $('#child').click()
    expect(MyLib.onClick).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should ignore clicks on a parent element', ->
    expect(MyLib.onClick).not.toHaveBeenCalled()
    $('#parent').click()
    expect(MyLib.onClick).not.toHaveBeenCalled()
